// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract MonitorearDeuda {

    // mapping de una address a otro mapping entre una address y un entero
    mapping(address => mapping(address => uint256)) public deuda;

    function setAmountOwed(
        address prestamista,
        address deudor,  
        uint256 cantidad
    ) 
        public {
            deuda[prestamista][deudor] = cantidad;
    }
}
