import { Request, Response, NextFunction } from 'express';

/**
 * Handles request data validation.
 */
export class UserMiddleware {

    /**
     * Validates email.
     * 
     * @note Allows both parameters and body fields!
     * @param req - The HTTP request.
     * @param res - The HTTP response.
     * @param next - The next function.
     * @returns `typeof next`.
     */
    static validateEmail(req: Request, res: Response, next: NextFunction) {
        const email = (req.params.email as string | undefined)
            ?? (req.body.email as string | undefined);
        if (typeof email !== 'string') {
            return res.status(400).json({ error: 'Email is required' });
        }
        // 
        const regex = /^[^@\s]+@[^@\s]+\.[^@\s]+$/;
        // 
        if (!regex.test(email)) {
            return res.status(400).json({ error: 'Invalid email format' });
        }
        next();
    }

    /**
     * Validates password.
     * 
     * @note Allows both parameters and body fields!
     * @param req - The HTTP request.
     * @param res - The HTTP response.
     * @param next - The next function.
     * @returns `typeof next`.
     */
    static validatePassword(req: Request, res: Response, next: NextFunction) {
        const password = req.body.password as string | undefined;
        if (typeof password !== 'string') {
            return res.status(400).json({ error: 'Password is required' });
        }

        const regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$/;

        if (!regex.test(password)) {
            return res.status(400).json({ error: 'Password must be at least 8 characters including one of each: uppercase character, lowercase character, number, special character' });
        }

        next();
    }

    // static validateUsername(req: Request, res: Response, next: NextFunction) {
    //     try {
    //         const username = 
    //     } catch {
    //         return res.status(400).json({ error: 'Invalid username' });
    //     }
    // }

    /**
     * Validates Uuid.
     * 
     * @note Allows both parameters and body fields!
     * @param req - The HTTP request.
     * @param res - The HTTP response.
     * @param next - The next function.
     * @returns `typeof next`.
     */
    static validateUuid(req: Request, res: Response, next: NextFunction) {
        try {
            const uuid = req.params.uuid as string | undefined;
            if (typeof uuid !== 'string') {
                return res.status(400).json({ error: 'Uuid is required' });
            }

            const regex = /^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;

            if (!regex.test(uuid)) {
                return res.status(400).json({ error: 'Invalid UUID format' })
            }
            next();
        } catch {
            return res.status(400).json({ error: 'Invalid ID' });
        }

    }

}
