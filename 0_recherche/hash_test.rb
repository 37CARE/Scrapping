a = [1,2,3]
b = ["a","b","c"]

grades = {}
i = 0
a.each do |key|
	grades["#{key}"]= b[i]
	i += 1
	end

loop {
puts grades
sleep(3)
}