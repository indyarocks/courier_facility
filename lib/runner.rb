# Require all files
require_relative 'courier_facility'
Dir[File.dirname(__FILE__) + '/courier_facility/*.rb'].each {|file| require file }

module CourierFacility
	class Runner
		attr_reader :execution_mode, :options

		def initialize(argv)
			if argv.empty?
				@execution_mode = :execute_command_line
				@options = {
					colorize: true
				}
			elsif argv.size == 1
				@execution_mode = :execute_input_file
				@options = {
					input_file: argv[0],
					colorize: false
				}
			else
				puts "Please execute the program without any argument or a single input file name".red
				exit(-1)
			end
		end

		def run
			send(execution_mode, options)
		end

		private
			def execute_command_line(options)
				while user_input = gets.chomp
					process_and_execute_command(user_input, options[:colorize])
				end
			end

			def execute_input_file(options)
				begin
					File.open(File.expand_path("./tmp/input/#{options[:input_file]}"), 'r') do |f|
					f.each_line do |line|
						command_text = line.chomp
						next if command_text.empty?
						process_and_execute_command(command_text, options[:colorize])
					end
				end
				rescue Errno::ENOENT
					puts "No such file found #{options[:input_file]}".red
					exit(-1)
				end
			end

			def process_and_execute_command(input_command_text, colorize)
				if input_command_text.to_s.downcase.strip == 'exit'
					message = colorize ? 'Bye Bye!' : 'Bye Bye'.green
					puts message
					exit
				end
				success, message = false, ''
				begin
					message = ::CourierFacility::CourierFacility.process_command(input_command_text)
	        success = true
	      rescue ::CourierFacility::Error => ex
	      	success = false
	        message = ex.message
	      end
	      if success 
	      	message = colorize ? message.green : message
	      else
	      	message = colorize ? message.red : message
	      end
	      puts message
			end
	end
end
