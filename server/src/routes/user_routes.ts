import { Router } from 'express';
import { UserController as Controller } from '../controllers/user_controller';
import { UserMiddleware as Middleware } from '../middlewares/user_middleware';

const router = Router();

router.get('/', Controller.getUsers);

// router.get('/uuid/:uuid', Middleware.validateUuid, Controller.getUserByUuid);

// router.get('/email/:email', Middleware.validateEmail, Controller.getUserByEmail);

router.post('/', Middleware.validateEmail, Middleware.validatePassword, Controller.createUser);

export default router;
