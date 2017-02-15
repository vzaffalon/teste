require 'net/http'
require 'date'
require "json"

def get_values(initial_date,end_date)
  values_array = Array.new
  while initial_date <= end_date
    request_url = 'http://api.fixer.io/' + initial_date.strftime("%Y-%m-%d") + '?base=USD&symbols=BRL'
    uri = URI(request_url)
    jsonResponse = JSON.parse(Net::HTTP.get(uri))
    values_array.push(jsonResponse['rates']['BRL'])
    $jsonArray.push(jsonResponse['date'])
    initial_date+=1
  end
  return values_array
end

$jsonArray = Array.new
initial_date = Date.new(2009,8,7)
end_date = Date.new(2011,11,17)
values_array = get_values(initial_date,end_date)
print '\nMaior valor foi: R$' +  values_array.max.to_s + ' no dia: ' + $jsonArray(values_array.each_with_index.max[1]).to_s
print '\nMenor valor foi: R$' + values_array.min.to_s + ' no dia: '  + $jsonArray(values_array.each_with_index.min[1]).to_s
print '\nA Média é: R$' + (values_array.inject{ |sum, el| sum + el }.to_f / values_array.size).to_s
