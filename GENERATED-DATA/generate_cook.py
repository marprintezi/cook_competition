from faker import Faker
import random

# Initialize the Faker library
fake = Faker()

# Function to generate cook data
def generate_cook_data(num_records):
    cooks = []
    for _ in range(num_records):
        first_name = fake.first_name()
        last_name = fake.last_name()
        phone_number = fake.phone_number()[:15]  # Ensure phone number is within 15 characters
        birth_date = fake.date_of_birth(minimum_age=20, maximum_age=60)
        age = fake.date_time_this_year().year - birth_date.year
        grade_id = random.randint(1, 5)  # Assuming there are 5 grades in the grade table
        
        cook = (first_name, last_name, phone_number, birth_date, age, grade_id)
        cooks.append(cook)
    
    return cooks

# Generate 100 records
num_records = 100
cook_data = generate_cook_data(num_records)

# Create SQL file and write the data
with open('C:\\Users\\marpr\\insert_cook_data.sql', 'w') as file:
    file.write("INSERT INTO cook (first_name, last_name, phone_number, birth_date, age, grade_id) VALUES\n")
    for i, cook in enumerate(cook_data):
        line = f"('{cook[0]}', '{cook[1]}', '{cook[2]}', '{cook[3]}', {cook[4]}, {cook[5]})"
        if i < num_records - 1:
            line += ",\n"
        else:
            line += ";\n"
        file.write(line)

print("SQL file created successfully with 100 records.")

