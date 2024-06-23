from faker import Faker

fake = Faker('pt_BR')

def get_fake_account():
    account = {
        "email": fake.email(),
        "name": fake.name()
    }
    return account