import { Component, OnInit } from '@angular/core';
import { ShareService } from '../services/share/share.service';
import { Router } from '@angular/router';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  constructor(private router: Router, private formBuilder: FormBuilder, private shared: ShareService) { 
  }

  loginForm: FormGroup;

  ngOnInit() {
    this.loginForm = this.formBuilder.group({
      username: ['', Validators.required],
      password: ['', Validators.required]
    })
  }

  onSubmit() {
    console.log(this.loginForm.value);
    if (this.loginForm.invalid) {
      return
    }
    this.shared.sharedUser = this.loginForm.value;
    this.router.navigateByUrl('/main');
    //do the login stuff with db
  }

  get formControls() { return this.loginForm.controls; }

}

