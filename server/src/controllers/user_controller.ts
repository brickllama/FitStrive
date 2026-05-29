import { Request, Response } from 'express';
import { UserService as Service } from '../services/user_service';

export class UserController {
    static async createUser(req: Request, res: Response) {
        try {
            const { email, firstName, lastName, password } = req.body;
            const result = await Service.createUser(email, firstName, lastName, password);
            if (result === null) {
                return res.status(409).json({ error: 'User exists' });
            }
            return res.status(201).json(result);
        } catch (error) {
            console.error('Error creating user: ', error);
            return res.status(500).json({ error: 'Internal server error' });
        }
    }

    static async getUsers(res: Response) {
        try {
            const result = await Service.getUsers();
            if (result === null) {
                return res.status(204).json({ error: 'No users found' });
            }
            return res.status(200).json(result);
        } catch (error) {
            console.error('Error fetching users: ', error);
            return res.status(500).json({ error: 'Internal server error' });
        }
    }
}
