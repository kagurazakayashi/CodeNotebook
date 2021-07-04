loadjson(data) {
    fetch('http://127.0.0.1/test.php' , {
      method: 'POST',
      headers: {
        // 'Accept': 'application/json',
      },
      body: data[1], //提交的数据
    }).then((response) => {
      if (response.ok) {
          return response.json(); // ->(returndata)
      }
    }).then((returndata) => {
      switch(data[0]){
        case 0://添加
          break;
        case 1://修改
          break;
        case 2://删除
          break;
        case 3://查询
          break;
        case 4://...
          break;
        case 5://...
          break;
        case 6://...
          break;
        case 7://...
          break;
        default:
          // this.setState({newstrocknum:returndata});
          break;
      }
    }).catch((error) => {
      console.log(error);
    });
  }
