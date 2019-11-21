import { Component, OnInit, ViewChild } from '@angular/core';
import { MatDialog, MatSort, MatDialogConfig, MatTable, MatTableDataSource } from '@angular/material';
import { ShareService } from '../services/share/share.service';
import { ActivatedRoute } from '@angular/router';
import { Validators, FormGroup, FormBuilder } from '@angular/forms';
import { Curso } from '../models/curso';
import { Mensaje } from '../models/mensaje';

var cursos: Curso[] = [];
var mensajes: Mensaje[] = [];

@Component({
  selector: 'app-main',
  templateUrl: './main.component.html',
  styleUrls: ['./main.component.css']
})
export class MainComponent implements OnInit {

  displayedColumns: string[] = ['name', 'code'];
  dataSource = new MatTableDataSource<Curso>(cursos);
  lotsData: any;
  messageForm: FormGroup;
  username: '';
  crss: Curso[];
  msjs = mensajes;
  blank = ' ';
  localUser: string;

  constructor(private formBuilder: FormBuilder, private route: ActivatedRoute, private shared: ShareService) { }

  ngOnInit() {
    this.dataSource.data = cursos;
    this.crss = cursos;
    //this.localUser = this.shared.sharedUser.username;
    console.log(this.localUser);

    this.messageForm = this.formBuilder.group({
      username: ['', Validators.required],
      message: ['', Validators.required]
    })
  }

  onSubmit() {
    console.log(this.messageForm.value);
    if (this.messageForm.invalid) {
      return console.log("Error al mandar msj");
    }
  }
}
