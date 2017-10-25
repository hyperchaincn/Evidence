contract Evidence{
    uint CODE_SUCCESS = 0;
    uint FILE_NOT_EXIST = 3002;
    uint FILE_ALREADY_EXIST  = 3003;
    uint USER_NOT_EXIST = 3004;

    struct FileEvidence{
    bytes fileHash;
    uint fileUploadTime;
    address owner;
    }
    struct User{
        address addr;
        uint count;
        mapping(bytes => FileEvidence) filemap;
    }
    
    // 文件hash对应的文件存证实体
    mapping(bytes => FileEvidence) fileEvidenceMap;

    // 交易hash对应的文件存证实体
    mapping(bytes => FileEvidence) tx2FileEvidenceMap;

    mapping(address => User) userMap;

    address[] userList;
    function saveEvidence(bytes fileHash,uint fileUploadTime) returns(uint code){
        //get filemap under sender
        User storage user = userMap[msg.sender];
        
        if (user.addr == 0x0) {
            user.addr = msg.sender;
            userList.push(msg.sender);
        } 
        FileEvidence storage fileEvidence = user.filemap[fileHash];
        if(fileEvidence.fileHash.length != 0){
            return FILE_ALREADY_EXIST;
        }
        user.count += 1;
        fileEvidence.fileHash = fileHash;
        fileEvidence.fileUploadTime = fileUploadTime;
        fileEvidence.owner = msg.sender;
        user.filemap[fileHash] = fileEvidence;
        return CODE_SUCCESS;
    }

    function getEvidence(bytes fileHash) returns(uint code,bytes fHash,uint fUpLoadTime,address saverAddress) {
        //get filemap under sender
        User storage user = userMap[msg.sender];
        if (user.addr == 0x0) {
            return (USER_NOT_EXIST,"",0,msg.sender);
        } 
        FileEvidence memory fileEvidence = user.filemap[fileHash];
        if(fileEvidence.fileHash.length == 0){
            return (FILE_NOT_EXIST,"",0,msg.sender);
        }
        
        return(CODE_SUCCESS,fileEvidence.fileHash,fileEvidence.fileUploadTime,msg.sender);
    }
    
    function getUsers() returns(address[] users){
        return userList;
    }
}
