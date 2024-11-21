# Mini Proyecto Token Exchange

Aquí está la información que necesitamos para crear nuestro 1er Mini Proyecto como parte de nuestro grupo de estudio:

Aunque no lo creas, ahora tienes suficiente conocimiento para construir un contrato inteligente muy simple de intercambio de tokens. Aquí está tu misión.

Construye dos contratos ERC20: **RareCoin** y **SkillsCoin** (puedes cambiar el nombre si lo prefieres). Cualquiera puede mintear SkillsCoin, pero la única forma de obtener RareCoin es enviando SkillsCoin al contrato de RareCoin. Necesitarás eliminar la restricción que solo permite al propietario mintear SkillsCoin.

Aquí está el flujo de trabajo:

- **mint()** SkillsCoin para ti mismo.
- **SkillsCoin.approve(address rareCoinAddress, uint256 yourBalanceOfSkillsCoin)** permite que RareCoin tome monedas de ti.
- **RareCoin.trade()** Esto hará que RareCoin llame a **SkillsCoin.transferFrom(address you, address RareCoin, uint256 yourBalanceOfSkillsCoin)**. Recuerda, RareCoin puede conocer su propia dirección con `address(this)`.
- **RareCoin.balanceOf(address you)** debería devolver la cantidad de RareCoin que originalmente minteaste con SkillsCoin.

Recuerda que **los tokens ERC20** (es decir, contratos) **pueden ser dueños de otros tokens ERC20**. Así que cuando llames a RareCoin.trade(), este debería llamar a SkillsCoin.transferFrom y transferir tu SkillsCoin a sí mismo, es decir, a `address(this)`.

Si tienes almacenada la dirección del contrato de SkillsCoin, se vería algo como esto:

```solidity
function trade(uint256 amount)
    public {
        // algún código
        // puedes pasar la dirección del contrato desplegado de SkillsCoin
        // como parámetro al constructor del contrato RareCoin como 'source'
        (bool ok, bytes memory result) = source.call(
            abi.encodeWithSignature(
                "transferFrom(address,address,uint256)",
                msg.sender,
                address(this),
                amount
            )
        );
        // esto fallará si no hay suficiente aprobación o balance
        require(ok, "call failed");
        // más código
}
```

Despliega estos contratos en Remix y prueba que funcionan.

Si eres nuevo en Solidity, reserva un par de días para esto. Muchos ingenieros se sienten confundidos por el hecho de que los balances se almacenan en los contratos inteligentes y no en las wallets, así que puede tomar algo de tiempo acostumbrarse a esto. Además, créeme, te sentirás confundido por las llamadas entre contratos.

## Más Instrucciones

Lo de arriba es practicamente una traducción literal del proyecto, y abajo iré poniendo (Garo) más indicaciones sobre cómo atacar este proyecto.

Cualquiera que guste puede mandar un PR con sugerencias o ponerlas en el grupo de Telegram!
