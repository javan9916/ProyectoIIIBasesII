import { Component, OnInit, ViewChild } from '@angular/core';
import { MatDialog, MatSort, MatDialogConfig, MatTable, MatTableDataSource } from '@angular/material';
import { ActivatedRoute } from '@angular/router';
import { Validators, FormGroup, FormBuilder } from '@angular/forms';
import { Curso } from '../models/curso';

var cursos: Curso[] = [];

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

  constructor(private formBuilder: FormBuilder, private route: ActivatedRoute) { }

  ngOnInit() {
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
