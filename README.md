# Evidence

基于Solidity语言的，适用于存证场景的智能合约示例

# 场景描述

“存证”即“保全”，保全即证据固定与保管，是指用一定的形式将证据固定下来，加以妥善保管，以供司法人员或律师、认定案件事实时使用。
文件hash一旦通过该合约存入区块链便不可删除和修改，可用于证明电子合同等法律文书的有效性。

方法清单：

- `function saveEvidence(bytes fileHash,uint fileUploadTime) returns(uint code)`:保存文件hash，文件hash会被保存到调用者的存证空间下；
- `function getEvidence(bytes fileHash) returns(uint code,bytes fHash,uint fUpLoadTime,address saverAddress)`:从调用者的存证空间中搜索该hash，若搜索到便返回响应的存证详情，否则返回搜索失败的相应提示；
- `function getUsers() returns(address[] users)`:查询用户列表，新的区块链账户若发起过saveEvidence请求，该账户便会被计入该列表。
