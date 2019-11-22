import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from "rxjs";

@Injectable({
  providedIn: 'root'
})
export class MensajeService {

  uri = 'http://localhost:3001';
  apiRoute = 'consultas';

  constructor(private _http: HttpClient) { }

  addMensajeEE(params: any): Observable<any> {
    return this._http.post(`${this.uri}/${this.apiRoute}/InsertarMensajeEE`, params, {observe: "response"});
  }

  addMensajeEP(params: any): Observable<any> {
    return this._http.post(`${this.uri}/${this.apiRoute}/InsertarMensajeEP`, params, {observe: "response"});
  }

  addMensajePE(params: any): Observable<any> {
    return this._http.post(`${this.uri}/${this.apiRoute}/InsertarMensajePE`, params, {observe: "response"});
  }

  addMensajeEG(params: any): Observable<any> {
    return this._http.post(`${this.uri}/${this.apiRoute}/InsertarMensajeEG`, params, {observe: "response"});
  }

  addMensajePG(params: any): Observable<any> {
    return this._http.post(`${this.uri}/${this.apiRoute}/InsertarMensajePG`, params, {observe: "response"});
  }

}
