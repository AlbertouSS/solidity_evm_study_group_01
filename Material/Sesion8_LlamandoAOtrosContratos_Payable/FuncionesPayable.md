# Funciones Payable

Ahora aprenderemos cómo un contrato inteligente puede interactuar con la criptomoneda Ether.

```solidity
contract Payable01 {
  function payMe() public payable {

  }

  function howMuchEtherIHave() public view returns (uint256) {
    return address(this).balance;
  }
}
```

Después de desplegar este contrato en Remix, verás que ahora tienes un botón rojo al cual puedes añadir ETH en el campo de entrada `value`. Puedes enviar Ether en unidades de Wei, Gwei, Finney o Ether.

Cuando llamamos a `howMuchEtherIHave()`, en realidad obtenemos `1000000000000000000`.

Esto se debe a que Ether usa la misma estrategia de decimales que los tokens ERC20. Así que en realidad estamos obteniendo 10^18 Wei, lo cual es equivalente a 1 Ether.

Por cierto, puedes usar este pequeño truco para determinar cuántos ETH tiene la dirección que llamó a nuestra función:

```solidity
contract Payable02 {
    function howMuchEtherYouHave() public view returns (uint256) {
        return msg.sender.balance;
    }

    function howMuchEtherTheyHave(address them) public view returns (uint256) {
        return them.balance;
    }
}
```

Si una función no tiene el modificador `payable`, revertirá si intentas enviar ether a ella.

Por cierto, Solidity proporciona una palabra clave muy conveniente para manejar todos los ceros involucrados con Ether. Ambas funciones hacen lo mismo, pero una es más legible.

```solidity
contract Payable03 {
    function moreThanOneEtherV1() public view returns (bool) {
        if (msg.sender.balance > 1 ether) {
            return true;
        }
        return false;
    }

    function moreThanOneEtherV2() public view returns (bool) {
        if (msg.sender.balance > 10**18) {
            return true;
        }
        return false;
    }
}
```

También es válido hacer que un constructor sea payable, pero aún necesitas enviar Ether explícitamente en el momento de la construcción. El hecho de que una función sea payable no significa que la persona que llama a la función tenga que enviar Ether.

```solidity
contract Payable04 {

    constructor() payable {
        // comenzar la vida con dinero
    }
}
```

## Enviar Ether

Es bastante sencillo enviar Ether cuando llamas a una función desde el IDE de Remix, pero ¿qué pasa si otro contrato quiere enviar Ether?

Así es como lo harías:

```solidity
contract ReceiveEther {
    function takeMoney() public payable {

    }

    function myBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

contract SendMoney {
    constructor() payable {

    }

    function sendMoney(address receiveEtherContract) public payable {
        uint256 amount = myBalance();
        (bool ok, ) = receiveEtherContract.call{value: amount}(
            abi.encodeWithSignature("takeMoney()")
        );
        require(ok, "transfer failed");
    }

    function myBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
```

Dado que, obviamente, cambiar el balance de un contrato inteligente es un _cambio de estado_, las funciones `payable` no pueden ser `view` o `pure`.

Links:

- [Ethereum Unit Converter](https://eth-converter.com/)
