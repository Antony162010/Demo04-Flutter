class Config {
  var url = 'http://178.128.14.222/BackMEAN/api';

  getUrl(){
    return this.url;
  }

  setUrl(uri){
    var result = this.url+uri;
    return result;
  }
}