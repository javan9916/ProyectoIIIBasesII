import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { LoginService } from '../services/login/login.service';
import { LoginDataSource } from '../services/login/login.datasource';
import { ShareService } from '../services/share/share.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  dataSource: LoginDataSource;
  resultado: boolean;
  coordenadas: any;

  constructor(private router: Router, private route: ActivatedRoute, private service: LoginService, 
    private formBuilder: FormBuilder, private shared: ShareService) { }

  loginForm: any;

  ngOnInit() {
    this.coordenadas = this.route.snapshot.data["cres"];
    console.log(this.coordenadas);
    this.loginForm = this.formBuilder.group({
      username: ['', Validators.required],
      password: ['', Validators.required]
    })

    this.dataSource = new LoginDataSource(this.service);
    this.dataSource.getEsclavos();
  }

  onSubmit() {
    console.log(this.service.formLogin);
    if(this.service.formLogin.valid){
      this.service.doLogin(this.service.formLogin.value)
        .subscribe(data => { 
          console.log(data)
          var loginSubject = data['content']  
          this.setResultado(loginSubject['0'])   
          });
    } 
    else {
      console.log('No ha ingresado todos los datos');
      this.service.inializeFormLogin();
      this.service.formLogin.reset();
    } 
  }

  setResultado(data: any){
    let resultado = data;
    console.log(resultado)
    if (resultado['codigo']){
      console.log('Bienvenido');
      this.router.navigateByUrl('/admin');
    }else{
      console.log('Por favor, verifique sus datos');
    }
    this.shared.sharedUser = this.loginForm.value;
    this.router.navigateByUrl('/main');
    //do the login stuff with db
  }

  get formControls() { return this.loginForm.controls; }

}

