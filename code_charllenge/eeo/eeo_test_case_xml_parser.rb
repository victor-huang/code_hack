require "rexml/document"
require 'yaml'

def get_all_test_cases_name(xml_file_path)

  xml_file = File.new(xml_file_path)
  
  doc = REXML::Document.new xml_file
  test_case_names = []

  doc.elements.each("//test") do |test_case|
    test_case_names.push test_case.attributes["name"].strip
  
  end

  test_case_names.sort!
  duplicate_list = []
  i = 0
  while i < test_case_names.size 
    if test_case_names[i] == test_case_names[i+1]
      while test_case_names[i] == test_case_names[i+1] and i < test_case_names.size 
        i += 1
      end
      puts "Duplicate test case found: #{test_case_names[i]}"
      duplicate_list.push(test_case_names[i])
    end
    i += 1
  end
  #ruby array add and subtract
  test_case_names = test_case_names - duplicate_list + duplicate_list #take awasy all the duplicates
  puts "Total number of test cases in xml is : #{test_case_names.size.to_s} "
  return test_case_names
end

def gen_yaml_mapping_file_from_xml(xml_file_path)
  xml_file = File.new(xml_file_path)
  
  eeo_yaml_mapping = {}
  
  doc = REXML::Document.new xml_file
  test_case_names = []
  doc.elements.each("//test") do |test_case|
    test_case_name = test_case.attributes["name"].strip

    eeo_yaml_mapping[ test_case_name ] = {}
    test_case.elements.each do |param|
      if param.attributes["name"]
        eeo_yaml_mapping[ test_case_name ][param.attributes["name"]] =
          param.attributes["value"]
      end
    end

  end

  File.open(xml_file_path.sub(/\.xml$/,".yml"), "w") do |yaml_file|
    yaml_file.puts eeo_yaml_mapping.to_yaml
  end
  puts "Created the yaml file at #{xml_file_path.sub(/\.xml$/,".yml")} "
end

def find_difference( test_case_names, selaf_eeo_tc_data)

  found_tcs = []
  not_found_tcs = []
  test_case_names.each do |tc_name|
    puts "Checking test case #{tc_name} : ..."
    if selaf_eeo_tc_data.has_key? tc_name
      puts "Found. - #{tc_name}"
      found_tcs.push tc_name
    else
      puts "Not found. #{tc_name}"
      not_found_tcs.push tc_name
    end
  end
  
  return [found_tcs, not_found_tcs]
end

#this function need to run under seladmin railscript
#tcs: test case name array
#ignore_set: this set will be subtract out from the tcs
def construct_suite_file(tcs, ignore_set)
  
  sql = "select id, qc_id from sel_test_scripts where qc_id in (#{tcs.join(",")})"
  
  test_scripts = SelTestScript.find(:all, :conditions=>[" qc_id in (?)", tcs])
  
  #runs the SQL commands with a list of records of selTestScript objects
  suite_file = File.open("./eeo_#{$$}.suite", "w")
  test_scripts.each do | script|
    if !ignore_set.include? script.id 
      suite_file.puts "TC" + script.id.to_s
    end
  end
  
  
  if suite_file.pos != 0 
    puts "Suite file generated at '#{suite_file.path}'."
  else
    puts "No test cases found in DB!"
  end
  
end

def find_unregister_test_case(tcs)

  unregistered_tcs = []
  tcs.each do |tc|
    test_script = SelTestScript.find(:all, :conditions=>[" qc_id in (?)", tc])
    if test_script.empty?
      puts "Test Case: #{tc} not registerd in DB"
      unregistered_tcs.push tc
    end
  end

  return unregistered_tcs
end

def find_duplicated_qc_id_in_db(tcs)
  duplicated_tcs = []
  ingore_tc_id_list = []
  tcs.each do |tc|
    test_script = SelTestScript.find(:all, :conditions=>[" qc_id in (?)", tc])
    if test_script.size > 1 
      puts "Test Case: #{tc} found duplicated in DB with ID #{test_script.map{|s| s.id}.inspect}"
      duplicated_tcs.push tc #pick one and then return them
      ingore_tc_id_list.push test_script[0].id
    end
  end

  return [duplicated_tcs, ingore_tc_id_list]

end

def gen_tc_suite_from_id_file(id_file)
  tc_id_file = File.open(id_file)
  new_file_path = id_file.sub(/\/(.*)$/, "\/\\1.gen")

  tc_id_file_generated = File.open(new_file_path, "w")
  tc_id_file.each_line do |line|
    tc_id_file_generated.puts "TC"+line if line != ""
  end

  tc_id_file_generated.close
  tc_id_file.close
  puts "Created new file #{new_file_path}"
end



if $0 == __FILE__ or true
  eeo_tc_data = YAML::load_file("./eeo_test_mappings.yml")
  tc_names = get_all_test_cases_name("./reg0908selafupdated-testng.xml")
  result = find_difference(tc_names , eeo_tc_data)
  
  find_unregister_test_case(tc_names)
  dup_obj = find_duplicated_qc_id_in_db(tc_names)
  construct_suite_file(result[0] , dup_obj[1] ) #get only the non-duplicated tc_id
  
  #construct_suite_file(["REPRTNG_Stmnt_0020","Opt_Plan_Outs_Vesting_RPT_0040"])
  #gen_tc_suite_from_id_file("./test.list")
  p gen_yaml_mapping_file_from_xml("./reg0908selafupdated-testng.xml")
end

