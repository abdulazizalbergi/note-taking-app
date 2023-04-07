import { LightningElement,api } from 'lwc';

export default class AppendHtml extends LightningElement {
    _result;
    loaded;
    set result(data){
        this._result =data;
        if(this.loaded){
            this.attachhtml();
        }
    }
    @api
    get result(){
        return this._result;
    }
    renderedCallback(){
        if(this._result && !this.loaded){
            this.attachhtml();
        }
    }
    attachhtml(){
        const container = this.template.querySelector('.htmlcontainer');
        if(container){
            container.innerHTML = this._result;
            this.loaded = true;
        }
    }
}