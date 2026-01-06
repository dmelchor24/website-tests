*** Settings ***
Documentation    Funciones especificas
Library    SeleniumLibrary
Resource    ../elementos/elementos.robot
Resource    ../variables/variables.robot
Library    SeleniumLibrary
Library    Collections
Library    OperatingSystem
Library    BuiltIn
Library    Process
Library    String

*** Keywords ***
Abrir Navegador
    Run Keyword If    '${HEADLESS}' == 'true'    Abrir Navegador Headless
    ...               ELSE    Abrir Navegador Visual
Abrir Navegador Visual
    Open Browser    ${BASE_URL}    ${BROWSER}
    #Set Window Size    1920    1080
    Maximize Browser Window

# Abrir Navegador Headless
#    Open Browser    ${BASE_URL}    ${BROWSER}    options=add_argument("--headless")
#    Maximize Browser Window

Abrir Navegador Headless
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --headless=new
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --window-size=1920,1080
    Open Browser    ${BASE_URL}    ${BROWSER}    options=${options}

Cerrar Navegador
    Close Browser

Ingresar credenciales válidas
    Wait Until Element Is Visible    ${InputUsuario}     ${TIMEOUT10S}
    Input Text    ${InputUsuario}    ${USERNAME}
    Input Text    ${InputContrasena}    ${PASSWORD}

Hacer login
    Click Button    ${BotonIniciarSesion}
Validar Login Exitoso
    Wait Until Element Is Visible    ${BotonCerrarSesion}    ${TIMEOUT10S}
Hacer Logout
    Click Button    ${BotonCerrarSesion}
Validar Logout
    Wait Until Element Is Visible    ${BotonIniciarSesion}    ${TIMEOUT10S}