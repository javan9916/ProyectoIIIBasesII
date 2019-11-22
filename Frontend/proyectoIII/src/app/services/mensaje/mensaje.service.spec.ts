import { TestBed } from '@angular/core/testing';

import { MensajeService } from './mensaje.service';

describe('MensajeService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: MensajeService = TestBed.get(MensajeService);
    expect(service).toBeTruthy();
  });
});
