Handled scenarios:

# create_parcel_slot_lot
- When a user try to take action on parking lot without creating one
- When user tries to create more than one parking lot 
- When user tries to create parking lot with odd/negative/zero number of slots

# deliver
- When user tries to deliver a non existing parking slot
- When user tries to deliver an available parking slot

# status
- Showing status of all slots (free or allocated). Else nothing will print if all slots are free.

# Park
- When a parcel already exists with a given parcel code

# slot_number_for_registration_number
- When invalid registration number is given

# Invalid file name input


# ASSUMPTIONS:
- All the numerical arguments are integer
- Input file should reside in /tmp/input folder

# Extra command
- When an invalid command is entered, program will return 'invalid_command'
- When 'exit' command is entered, program will say 'Bye Bye' and exit

