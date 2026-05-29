import { hash } from 'bcrypt';
import { randomUUID } from 'crypto';
import { UserRepository as Repository } from '../repositories/user_repository';

/**
 * Handles user business logic.
 */
export class UserService {

    /**
     * Create a new user.
     * @param email - The user's email address.
     * @param firstName - First name.
     * @param lastName - Last name.
     * @param password - The user's Password.
     * @returns The created `UserDTO`.
     */
    static async createUser(email: string, firstName: string, lastName: string, password: string) {
        const uuid = randomUUID();
        const passwordHash = await hash(password, 12);
        return Repository.createUser(uuid, email, firstName, lastName, passwordHash);
    }

    /**
     * Gets all users.
     * @returns `UserDTO[]`.
     */
    static async getAllUsers() {
        return Repository.getAllUsers();
    }

    /**
     * Gets a user by email.
     * @param email - The user's email
     * @returns `UserDTO`.
     */
    static async getUserByEmail(email: string) {
        return Repository.getUserByEmail(email);
    }

    /**
     * Gets a user by UUID.
     * @param uuid - The user's UUID.
     * @returns `UserDTO`.
     */
    static async getUserByUuid(uuid: string) {
        return Repository.getUserByUuid(uuid);
    }
}
