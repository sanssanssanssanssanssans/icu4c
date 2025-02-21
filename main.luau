type icu4c = {
	encode: (input: string, encoding: string) -> string,
	decode: (input: string, encoding: string) -> string,  
	compare: (str1: string, str2: string, locale: string) -> boolean, 
}

local module = {} :: icu4c

function module.encode(input:string,encoding:string) : string
	if encoding == "UTF-8" or encoding == "utf-8" then
		return input
	elseif encoding == "ASCII" or encoding == "ascii" then
		local res = ""
		for i=1, #input do
			local char = input:sub(i,i)
			local byte = string.byte(char)
			if byte <= 127 then
				res = res..char
			end
		end
		return res
	elseif encoding == "Latin1" or encoding == "latin1" then
		local res = ""
		for i=1, #input do
			local char = input:sub(i,i)
			local byte = string.byte(char)
			if byte <= 255 then
				res = res..char
			else 
				res = res.."?"
			end
		end
	else 
		error("Unsupported Encoding: "..encoding)
	end	
end

function module.decode(input:string,encoding:string):string
	if encoding == "UTF-8" or encoding == "utf-8" then
		return input
	elseif encoding == "ASCII" or encoding == "ascii" then
		local res = ""
		for i=1, #input do
			local char = input:sub(i,i)
			local byte = string.byte(char)
			if byte <= 127 then
				res = res..char
			else
				res = res.."?"
			end
		end
		return res
	elseif encoding == "Latin1" or encoding == "latin1" then
		local res = ""
		for i=1, #input do
			local char = input:sub(i,i)
			local byte = string.byte(char)
			if byte <= 255 then
				res = res..char
			else
				res = res.."?"
			end
		end
		return res
	else
		error("Unsurpported encoding "..encoding)
	end
end

function module.compare(str1: string, str2: string, caseSensitive: boolean, encoding: string) : number
	if not caseSensitive then
		str1 = str1:lower()
		str2 = str2:lower()
	end
	if encoding == "UTF-8" or encoding == "utf-8" then
		if str1 == str2 then
			return 0
		elseif str1 < str2 then
			return -1
		else 
			return 1
		end
	elseif encoding == "ASCII" or encoding == "ascii" then
		local str11 = str1:gsub("[^%w%s]","")
		local str22 = str2:gsub("[^%w%s]","")
		if str11 == str22 then
			return 0
		elseif str11 < str22 then
			return -1
		else
			return 0
		end
	elseif encoding == "Latin1" or encoding == "latin1" then
		local str11 = str1:gsub("[^%w%s]","")
		local str22 = str2:gsub("[^%w%s]","")
		if str11 == str22 then
			return 0
		elseif str11 < str22 then
			return -1
		else
			return 0
		end
	else
		error("Unsurpported encoding "..encoding)
	end
end

return module
