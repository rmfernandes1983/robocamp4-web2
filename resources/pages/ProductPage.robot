*** Settings ***
Documentation    Este arquivo implementa funções e elementos da página Produtos

***Variables***
${BUTTON_PRODUCT_ADD}           class:product-add

*** Keywords ***
Go To Product Form
    Wait Until Element Is Visible    ${BUTTON_PRODUCT_ADD}
    Click Element                    ${BUTTON_PRODUCT_ADD}
    Wait Until Page Contains         Novo Produto

Create New Product
    [Arguments]    ${product_json}

    Input Text       css:input[name=title]    ${product_json['name']}
    
    Run Keyword if      "${product_json['cat']}"
    ...     Select Category    ${product_json['cat']}

    Input Text         css:input[name=price]     ${product_json['price']}

    Input Producers    ${product_json['producers']}
    Input Text         css:textarea[name=description]    ${product_json['desc']}

    Run Keyword if      "${product_json['image']}"
    ...     Upload Photo    ${product_json['image']}

    Click Element    id:create-product

Upload Photo
    [Arguments]    ${image}

    ${file}        Set Variable    ${EXECDIR}/resources/fixtures/images/${image}
    Choose File    id:upcover      ${file}

Select Category
    [Arguments]    ${cat}

    Click Element    css:input[placeholder=Gategoria]

    Set Selenium Speed   1
    Wait Until Element Is Visible    class:el-select-dropdown__list
    Click Element                    xpath://li/span[text()='${cat}']
    Set Selenium Speed   0

Input Producers
    [Arguments]    ${producers}

    : FOR    ${item}    IN    @{producers}
    \    Log           ${item}
    \    Input Text    class:producers    ${item}
    \    Press Keys    class:producers    TAB