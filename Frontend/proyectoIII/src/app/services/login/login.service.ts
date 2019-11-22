import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from "@angular/common/http";
import { FormGroup, FormControl, Validators} from '@angular/forms';
import { Usuario } from "../../models/usuario";

import * as _ from 'lodash';

@Injectable({
  providedIn: 'root'
})
export class LoginService {

  driver: Array<Usuario>;

  uri = 'http://localhost:3001';

  constructor(private _http: HttpClient) { }

  //Datos del formulario de inicio de sesion
  formEsclavo: FormGroup = new FormGroup({
    usuario: new FormControl('', Validators.required),
    contraseña: new FormControl('', Validators.required),
    direccion_ip: new FormControl('', Validators.required),
    nombre_db: new FormControl('', Validators.required),
    distancia: new FormControl('', Validators.required),
  });

  formLogin: FormGroup = new FormGroup({
    UserName: new FormControl('', Validators.required),
    Password: new FormControl('', Validators.required),
    Server: new FormControl('', Validators.required),
    Port: new FormControl('', Validators.required),
    DataBase: new FormControl(null)
  });

  inializeFormLogin(){
    this.formLogin.setValue({
      UserName: '',
      Password: '',
      Server: '',
      Port: '',
      DataBase: null
    })
  }

  doLogin(data){
    return this._http.get(`${this.uri+'/login/login'}`,{
      params: new HttpParams()
      .set('User', this.formEsclavo.get('usuario').value)
      .set('Password',this.formEsclavo.get('contrasena').value)
      .set('Server', this.formEsclavo.get('direccion_ip').value)
      .set('Usuario', data.UserName)
      .set('Contraseña', data.Password)
    });
  }

  getEsclavos(){
    return this._http.get(`${this.uri+'/login/getEsclavos'}`,{
      params: new HttpParams()
      .set('latitud','-84.4747213')
      .set('longitud','10.3642467')
    });
  }

  setEsclavoActual(esclavo){
    this.formEsclavo.setValue(_.omit(esclavo));
  }

}
