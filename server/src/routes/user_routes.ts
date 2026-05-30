import { Router } from 'express';
import { UserController as Controller } from '../controllers/user_controller';
import { UserMiddleware as Middleware } from '../middlewares/user_middleware';

const router = Router();

router.delete('/:uuid', Middleware.validateUuid, Controller.delete);

router.get('/', Controller.getAll);

router.post('/login', Middleware.validateEmail, Middleware.validatePassword, Controller.login);

router.post('/register', Middleware.validateEmail, Middleware.validatePassword, Controller.register);

export default router;
