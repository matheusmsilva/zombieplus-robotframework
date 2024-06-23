*** Settings ***
Resource    ../resources/Base.resource

Suite Setup   Run Keywords    
...    Connect To Zombie Database    
...    AND
...    Delete All From Leads

Test Setup    Visit Lead Page

Suite Teardown    Disconnect From All Databases

*** Test Cases ***
Should register a new lead
    ${account}    Get Fake Account
    Open Lead Modal
    Submit Lead Form    ${account}[name]    ${account}[email]
    Popup Should Have Text    Agradecemos por compartilhar seus dados conosco. Em breve, nossa equipe entrará em contato.

Should not register when e-mail already exists
    ${account}    Get Fake Account
    Post New Lead By API    ${account}
    Open Lead Modal
    Submit Lead Form    ${account}[name]    ${account}[email]
    Popup Should Have Text    Verificamos que o endereço de e-mail fornecido já consta em nossa lista de espera. Isso significa que você está um passo mais perto de aproveitar nossos serviços.

Should not register when e-mail is invalid
    Open Lead Modal
    Submit Lead Form    John Doe    john.doe.ocm
    Alert Should Have Text    Email incorreto

Should not register when e-mail is not filled
    Open Lead Modal
    Submit Lead Form    John Doe    ${EMPTY}
    Alert Should Have Text   Campo obrigatório

Should not register when name is not filled
    Open Lead Modal
    Submit Lead Form    ${EMPTY}    johndoe@gmail.com
    Alert Should Have Text   Campo obrigatório

Should not register when mandatory filds are not informed
    Open Lead Modal
    Submit Lead Form    ${EMPTY}    ${EMPTY}
    @{expected_alerts}    Create List    Campo obrigatório    Campo obrigatório
    Multiple Alerts Should Have Text   ${expected_alerts}