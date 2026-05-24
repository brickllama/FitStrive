import { Request, Response } from 'express';
import { UserService as Service } from '../services/user_service';

/**
 * Handles user endpoints.
 */
export class UserController {

    /**
     * Creates a new user.
     * 
     * Reads `email`, `name`, and `password` from the request body, calls
     * the UserService to create the user, and returns the created user.
     * 
     * Success response: 201 Created with body { uuid, email, name }.
     * 
     * @param req - The HTTP request.
     * @param res - The HTTP response.
     * @returns The created `UserDTO`.
     */
    static async createUser(req: Request, res: Response) {
        try {
            const { email, name, password } = req.body;
            const user = await Service.createUser(email, name, password);
            return res.status(201).json(user);
        } catch (error) {
            console.error('Error creating user: ', error);
            return res.status(500).json({ error: 'Internal server error' });
        }
    }

    /**
     * Gets all users.
     * 
     * Calls the UserService to fetch all users and return them.
     * 
     * Success response: 200 OK with Array<{ uuid, email, name }>.
     * 
     * @param req - The HTTP request.
     * @param res - The HTTP response.
     * @returns `UserDTO[]`.
     */
    static async getUsers(req: Request, res: Response) {
        try {
            const users = await Service.getAllUsers();
            return res.json(users);
        } catch (error) {
            console.error('Error fetching users: ', error);
            return res.status(500).json({ error: 'Internal server error' });
        }
    }

    /**
     * Gets a user by UUID.
     * 
     * Reads `uuid` from request parameters, calls the UserService, and returns the user.
     * 
     * 
     * Success Response: 200 OK with body { uuid, email, name }.
     * 
     * Not Found response: 404 Not Found with { error: 'User not found' }.
     * 
     * @param req - The HTTP request.
     * @param res - The HTTP response.
     * @returns `UserDTO`.
     */
    static async getUserByUuid(req: Request<{ uuid: string }>, res: Response) {
        try {
            const { uuid } = req.params;
            const user = await Service.getUserByUuid(uuid);
            if (!user) {
                return res.status(404).json({ error: 'User not found' });
            }
            return res.json(user);
        } catch (error) {
            console.error('Error fetching user by uuid: ', error);
            return res.status(500).json({ error: 'Internal server error' });
        }
    }

    /**
     * Gets a user by email.
     * 
     * Reads `email` from request parameters, calls the UserService, and returns the user.
     * 
     * Success Response: 200 OK with body { uuid, email, name }.
     * 
     * Not Found response: 404 Not Found with { error: 'User not found' }.
     * 
     * @param req - The HTTP request.
     * @param res - The HTTP response.
     * @returns `UserDTO`.
     */
    static async getUserByEmail(req: Request<{ email: string }>, res: Response) {
        try {
            const { email } = req.params;
            const user = await Service.getUserByEmail(email);

            if (!user) {
                return res.status(404).json({ error: "User not found" });
            }

            return res.json(user);
        } catch (error) {
            console.error("Error fetching user by email:", error);
            return res.status(500).json({ error: "Internal server error" });
        }
    }

}
