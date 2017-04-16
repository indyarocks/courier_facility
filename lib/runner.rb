# Require all lib files
Dir[File.dirname(__FILE__) + '/courier_facility/*.rb'].each {|file| require file }

module CourierFacility
	class Runner
		attr_reader :execution_mode, :options

		def initialize(argv)
			if argv.empty?
				@execution_mode = :command_line
			elsif argv.size == 1
				@execution_mode = :input_file
				@options = {
					input_file: argv[0]
				}
			else
				puts "Please execute the program without any argument or a single input file name".red
				exit(-1)
			end
		end

		def run
			if execution_mode == :command_line
					while user_input = gets.chomp
					if user_input.to_s.downcase.strip == 'exit'
						puts "Bye bye!".green
						break
						exit
					end
					puts user_input.green
				end
			elsif execution_mode == :input_file
				begin
					File.open(File.expand_path("./tmp/input/#{options[:input_file]}"), 'r') do |f|
					f.each_line do |line|
						puts line
					end
				end
				rescue Errno::ENOENT
					puts "No such file found #{options[:input_file]}".red
					exit(-1)
				end
			end
		end

		def preprocess_command(command_text)
		# Pre process the text command
		end

		def park(code, weight)
			# Check if slot available
		  # return error if full
			parcel = Parcel.new(args)	
			parcel.allocate_nearest_parcel_slot
		end	

		def status
			# Check the status of all the parcelSlot
		end
		
		def deliver_parcel
			# unallocate the slot
		end

		def parcel_code_for_parcels_with_weight(weight)
		end

		def slot_numbers_for_parcesl_with_weight(weight)
		end

		def slot_number_for_registration_number(code)
		end
	end
end
