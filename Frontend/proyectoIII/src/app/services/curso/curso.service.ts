import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from "@angular/common/http";
import { Observable } from "rxjs";


@Injectable({
  providedIn: 'root'
})
export class CursoService {
  
  uri = 'http://localhost:3001';
  apiRoute = 'consultas';

  constructor(private _http: HttpClient) { }

  getCursosEstudiante(params: any): Observable<any> {
    return this._http.get(`${this.uri}/${this.apiRoute}/MostrarCursosEstudiantes`, {
      params: params,
      observe: 'response'
    });
  }

  getCursosProfesor(params: any): Observable<any> {
    return this._http.get(`${this.uri}/${this.apiRoute}/MostrarCursosProfesores`, {
      params: params,
      observe: 'response'
    });
  }

  getEstudianteCurso(params: any): Observable<any> {
    return this._http.get(`${this.uri}/${this.apiRoute}/MostrarEstudiantesCurso`, {
      params: params,
      observe: 'response'
    });
  }

  getProfesorCurso(params: any): Observable<any> {
    return this._http.get(`${this.uri}/${this.apiRoute}/MostrarProfesoresCurso`, {
      params: params,
      observe: 'response'
    });
  }
}
