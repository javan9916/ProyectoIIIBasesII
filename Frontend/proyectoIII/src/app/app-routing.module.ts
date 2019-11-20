import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LoginComponent } from '../app/login/login.component';
import { MainComponent } from '../app/main/main.component';
import { ResolverService }  from '../app/services/resolver/resolver.service';

const routes: Routes = [
  { path: '', redirectTo: 'login', pathMatch: 'full' },
  { path: 'login', component: LoginComponent, resolve: {cres: ResolverService}},
  { path: 'main', component: MainComponent,},
  { path: '**', redirectTo: 'login' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
  providers: [ResolverService]
})
export class AppRoutingModule { }
