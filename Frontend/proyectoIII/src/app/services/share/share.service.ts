import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ShareService {
  sharedUser: {
    username: string,
    password: string
  };
}
