helpers do 

	def current_user
		if session['user_id']
			@current_user ||= User.find_by_id(session['user_id'])	
		end
	end

	def logged_in
		!current_user.nil?
	end

	def break_lines(content)
		puts content.inspect
		new_content = content.to_s.gsub("/\n\r/", 'Š')
		puts new_content.inspect
		new_content
	end

	def truncate(str, option = {})
		max_length = option[:length] ||= 150
		end_string = option[:end_string] ||= '...'

			if str.kind_of? String
				return if str.nil?
				if str.length > max_length
					str.slice!(max_length..str.length)
					str += end_string
				end
				str
			end
	end

end