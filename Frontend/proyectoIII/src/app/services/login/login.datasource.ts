import {LoginService} from "./login.service";
import { Esclavo } from 'src/app/modals/esclavo.model';
import { BehaviorSubject } from 'rxjs';

export class LoginDataSource {

    private esclavoSubject = new BehaviorSubject<Esclavo[]>([]);
    private esclavo: Esclavo
    
    constructor(private service: LoginService) { }

    ngOnInit() {
    }
    
    //LLama al servicio de Login
    Login(){
        this.service.doLogin(this.service.formLogin.value).subscribe();
    }

    getEsclavos(){
        this.service.getEsclavos()
        .subscribe(data =>{
            let content = data['content'];
            this.esclavo = content['0'];
            this.service.setEsclavoActual(this.esclavo) 
        });
    }
}