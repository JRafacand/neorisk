Feature: Test API Demoblaze

  Scenario Outline: Create user sign up
    Given url "https://api.demoblaze.com"
    Given path "/signup"
    And request {username: "<username>", password: "<password>"}
    When method post
    And def statusCode = responseStatus
    And match statusCode == 200
    Then if (statusCode == 200) karate.log("El usuario se creo correctamente")
    * if (statusCode== 500) karate.log("Servidor no Responde")
    Examples:
      | username | password |
      | Rafakarate12 | karate1 |
      | Rafakarate22 | karate2 |
      | Rafakarate32 | karate3 |


  Scenario Outline: Create exist user on sign up
    Given url "https://api.demoblaze.com"
    Given path "/signup"
    And request {username: "<username>", password: "<password>"}
    When method post
    And def statusCode = responseStatus
    And match statusCode == 200
    And def responseJson = response
    And match responseJson ==  {"errorMessage":"This user already exist."}
    And def customMessage = "El usuario ya existe "
    And if (responseJson.errorMessage == "This user already exist.") karate.log(customMessage)
    * if (statusCode== 500) karate.log("Servidor no Responde")
    Examples:
      | username | password |
      | Rafakarate12 | karate1 |
      | Rafakarate22 | karate2 |
      | Rafakarate32 | karate3 |

  Scenario Outline: login successfull
    Given url "https://api.demoblaze.com"
    Given path '/login'
    And request {username: "<username>", password: "<password>"}
    When method post
    And def statusCode = responseStatus
    And match statusCode == 200
    And def responseJson = response
    And karate.log(responseJson)
    And if (responseJson != null) karate.log("El usuario se logeo correctamente")
    * if (statusCode== 500) karate.log("Servidor no Responde")
    Examples:
      | username | password |
      | Rafakarate12 | karate1 |
      | Rafakarate22 | karate2 |
      | Rafakarate32 | karate3 |


  Scenario Outline: login wrong password
    Given url "https://api.demoblaze.com"
    Given path '/login'
    And request {username: "<username>", password: "<password>"}
    When method post
    And def statusCode = responseStatus
    And match statusCode == 200
    And def responseJson = response
    And match responseJson ==  {"errorMessage":"Wrong password."}
    And def customMessage = "Clave o usuario incorrecto"
    And if (responseJson.errorMessage == "Wrong password.") karate.log(customMessage)
    * if (statusCode== 500) karate.log("Servidor no Responde")
    Examples:
      | username | password |
      | Rafakarate12 | karate12 |
      | Rafakarate22 | karate22 |
      | Rafakarate32 | karate32|