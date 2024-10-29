// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.4.22 <0.9.0;

import "remix_tests.sol"; 
import "remix_accounts.sol";
import "./Cadenas2.sol";

contract testSuite {

    function checkResult() public {
        Cadenas texto = new Cadenas();
        Assert.equal("Hola", texto.regresaCadena(), "La cadena debe ser iguala a 'Hola'");
    }

}
    