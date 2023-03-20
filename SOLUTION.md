### 3. TinySig

https://cryptobook.nakov.com/digital-signatures/ecdsa-sign-verify-examples
https://m.youtube.com/watch?v=6TI5YOpnrgI&embeds_euri=https%3A%2F%2Fwww.hypr.com%2F&source_ve_path=MjM4NTE&feature=emb_title
https://bitcoin.stackexchange.com/questions/38351/ecdsa-v-r-s-what-is-v
https://www.instructables.com/Understanding-how-ECDSA-protects-your-data/?amp_page=true
https://asecuritysite.com/encryption/ecd2
https://cryptodeeptech.ru/shortest-ecdsa-signature/

```sh
eas src/TinySig.etk src/TinySig.hex
```

```sh
cast call 0x000000000045E5418329Ee1F6D07Dc6E73ad0AB0 "curtaPlayer()"
```

```sh
forge script script/TinySig.s.sol --broadcast -f $ETH_RPC_URL --tx-origin 0x4fd9D0eE6D6564E80A9Ee00c0163fC952d0A45Ed
```

```sh
forge script script/TinySig.s.sol --broadcast -f $ETH_RPC_URL --tx-origin 0x79d31bfca5fda7a4f15b36763d2e44c99d811a6c
```

### 2. F1A9

## Deployed address
```sh
cast call 0xf1a9b2ca2acfdd4bf9d004dd72ed774b01ef5696 "curtaPlayer()"
```

## Generate
```sh
cast call 0x9f00c43700bc0000Ff91bE00841F8e04c0495000 "generate(address)" 0x4fd9D0eE6D6564E80A9Ee00c0163fC952d0A45Ed
```

## Test (0x73d010a92e83495cb596debc9bde74f95a458feb)
```sh
cast call 0x73d010a92e83495cb596debc9bde74f95a458feb "generate(address)" 0x4fd9D0eE6D6564E80A9Ee00c0163fC952d0A45Ed
cast call 0x73d010a92e83495cb596debc9bde74f95a458feb "verify(uint256)" 0x000000000000000000000000000000000000000000000000000000000000e6d6
```

## Bytecode

```sh
6080604052348015600f57600080fd5b50608680601d6000396000f3fe6080604052348015600f57600080fd5b506004361060285760003560e01c8063a567a8fa14602d575b600080fd5b604080516f06bc8d9e5e9d436217b88de704a9f307815290519081900360200190f3fea2646970667358221220609af2ba794fb6bdfcfa6f2f848fad9d309967a4a6c4a18aee7628124814ff4e64736f6c63430008110033
```

## Create2
```sh
cast c2 -s f1a980a9 -i 6080604052348015600f57600080fd5b50608680601d6000396000f3fe6080604052348015600f57600080fd5b506004361060285760003560e01c8063a567a8fa14602d575b600080fd5b604080516f06bc8d9e5e9d436217b88de704a9f307815290519081900360200190f3fea2646970667358221220609af2ba794fb6bdfcfa6f2f848fad9d309967a4a6c4a18aee7628124814ff4e64736f6c63430008110033
```

## Eradicate2
Credits: https://hackmd.io/@onemanbandplus2/H1RQh9hCc
```sh
./ERADICATE2.x64 -A 0x4e59b44847b379578588920cA78FbF26c0B4956C -I 6080604052348015600f57600080fd5b50608680601d6000396000f3fe6080604052348015600f57600080fd5b506004361060285760003560e01c8063a567a8fa14602d575b600080fd5b604080516f06bc8d9e5e9d436217b88de704a9f307815290519081900360200190f3fea2646970667358221220609af2ba794fb6bdfcfa6f2f848fad9d309967a4a6c4a18aee7628124814ff4e64736f6c63430008110033 --matching f1a9e00c
```

## Deploy
```sh
forge script script/F1A9.s.sol --broadcast -f $ETH_RPC_URL --sender $DEPLOYER_ADDRESS -t
```

0x00000000000000000000000000000000000000000000000000000000f1a96d65
0x000000000000000000000000f1a96d654114ce69b7680b32a01a46bc0d3d7f02