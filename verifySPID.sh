require 'csv'
require 'set'

#idFile = "spId.txt"
#crtvFile = "crtvscore.csv"


idFile = ARGV[0]
crtvFile = ARGV[1]

if(!idFile || !crtvFile) then
  puts "================================"
  puts "USAGE: verifySPID.sh arg1 arg2\n" + "arg1: spid file.    arg2: creative score file"
  puts "================================"  
exit
end


puts "Retrive site placement ids from file: #{idFile}"
puts "Parse creative score file: #{crtvFile}"
#ids = File.readlines(idFile)

ids = []
File.open(idFile).each_line do |line|
  ids << line.delete("\n")
end


allid = Set.new
CSV.foreach(crtvFile) do |row|
  allid.add(row[3])
end


existId = Set.new
nonexistId = Set.new

ids.each do |id|
  if allid.include?(id) then
    existId.add(id)
  else
    nonexistId.add(id)
  end
end

puts
puts "Existed site placement id:"
existId.each{|id| puts id}

puts "non-existed site placement id:"
nonexistId.each{|id| puts id}
