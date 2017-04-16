### Ruby Version: 2.4.0

### Setup
1. Download the source code and unzip
2. cd to root directory of program
3. `bundle install`
4. Make program file executable
  `chmod +x bin/courier_facility.rb`

### How to use:
1. Interactive mode:
  - cd to root directory
  - execute 
  
  `./bin/courier_facility.rb`

2. File input mode:
 - Ensure input file existins in `/tmp/input`
 - execute following command.
 
 `./bin/courier_facility.rb <file_name>`

You will have to provide just the filename, not the complete path.
e.g. If you have placed `input_file.txt` inside `/tmp/input`, your execution command will be:

 `./bin/courier_facility.rb input_file.txt`


### Tests:
1. cd to root directory
2. `rspec`


### ASSUMPTIONS:
- All the numerical arguments are integer
- Input file should reside in /tmp/input folder

### Bonus commands
- When an invalid command is entered, program will return 'invalid_command'
- When 'exit' command is entered, program will say 'Bye Bye' and exit

###Edge-Case scenarios:

#### create_parcel_slot_lot

- When a user try to take action on parking lot without creating one
- When user tries to create more than one parking lot 
- When user tries to create parking lot with odd/negative/zero number of slots

#### deliver

- When user tries to deliver a non existing parking slot
- When user tries to deliver an available parking slot

#### status

- Showing status of all slots (free or allocated). Else nothing will print if all slots are free.

#### Park

- When a parcel already exists with a given parcel code

#### slot_number_for_registration_number

- When invalid registration number is given

#### Invalid file name input

- When the input file doesn't exists inside `/tmp/input`

