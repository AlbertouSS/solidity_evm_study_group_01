// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.4.22 <0.9.0;

import "remix_tests.sol";
import "../contracts/Reto_Mappings.sol";

contract testSuite {

    NumerosEspeciales numeros = new NumerosEspeciales();

    function validarEspecial() public {
        numeros.hacerNumeroEspecial(10);
        Assert.equal(true, numeros.elNumeroEsEspecial(10), "Se espera que el valor 10 sea especial");
    }
        function validarNoEspecial() public {
        numeros.hacerNumeroNoEspecial(0);
        Assert.equal(false, numeros.elNumeroEsEspecial(0), "Se espera que el valor 0 NO sea especial");
    }
}