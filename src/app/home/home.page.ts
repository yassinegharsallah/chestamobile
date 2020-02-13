import { Component } from '@angular/core';
import { NavController } from '@ionic/angular';
import { RegisterPage } from '../register/register.page';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage {
  email:string ; 
  password:string ; 
  constructor(public navCtrl: NavController,private http: HttpClient) { }
login(){
  this.http.post('https://someapi.com/posts', {
    content: 'hello',
    submittedBy: 'Josh'
}).subscribe((response) => {
    console.log(response);
});

  console.log(this.email) ;
  console.log(this.password) ;  
  
}
registerModal() {
  this.navCtrl.navigateRoot('register');
}
}
