import { Request, Response } from 'express';
import { UserService as Service } from '../services/user_service';

export class UserController {

    static async delete(req: Request<{ uuid: string }>, res: Response) {
        try {
            const { uuid } = req.params;
            const result = await Service.delete(uuid);

            if (result === false) {
                return res.status(404).json({ error: 'User not found' });
            }

            return res.status(204).send();
        } catch (error) {
            console.error('Error deleting user: ', error);
            return res.status(500).json({ error: 'Internal server error' });
        }
    }

    static async getAll(req: Request, res: Response) {
        try {
            const users = await Service.getAll();
            if (!users) {
                return res.status(204).send();
            }
            return res.status(200).json(users);
        } catch (error) {
            console.error('Error fetching users: ', error);
            return res.status(500).json({ error: 'Internal server error' });
        }
    }

    static async login(req: Request, res: Response) {
        try {
            const { email, password } = req.body;
            const user = await Service.login(email, password);
            if (!user) {
                return res.status(401).json({ error: 'Invalid email or password' });
            }
            return res.status(200).json(user);
        } catch (error) {
            console.error('Error fetching user: ', error);
            return res.status(500).json({ error: 'Internal server error' });
        }
    }

    static async register(req: Request, res: Response) {
        try {
            const { email, username, firstName, lastName, password } = req.body;
            const user = await Service.register(email, username, firstName, lastName, password);
            if (!user) {
                return res.status(409).json({ error: 'User exists' });
            }
            return res.status(201).json(user);
        } catch (error) {
            console.error('Error creating user: ', error);
            return res.status(500).json({ error: 'Internal server error' });
        }
    }
}
