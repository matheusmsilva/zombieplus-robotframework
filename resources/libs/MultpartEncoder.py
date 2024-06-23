import requests
from requests_toolbelt import MultipartEncoder

def create_multipart_data(data):
    fields = {key: str(value) for key, value in data.items()}
    multipart_data = MultipartEncoder(fields=fields)
    return multipart_data, multipart_data.content_type

def post_multipart_formdata(url, data, auth_token):
    multipart_data, content_type = create_multipart_data(data)
    headers = {
        'Authorization': auth_token,
        'Content-Type': content_type,
        'Accept': 'application/json, text/plain, */*'
    }
    response = requests.post(url, headers=headers, data=multipart_data)
    return response.json()
