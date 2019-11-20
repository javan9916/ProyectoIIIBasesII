import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from "@angular/common/http";
import { Observable } from "rxjs";
import { Usuario } from "../../models/usuario";

@Injectable({
  providedIn: 'root'
})
export class LoginService {
  driver: Array<Usuario>;
  apiRoute: String = "usuarios";
  env = {
    BASE_URL: ''
  }

  constructor(private _http: HttpClient) { }

  doLogin(params: any) {
    
  }
}
