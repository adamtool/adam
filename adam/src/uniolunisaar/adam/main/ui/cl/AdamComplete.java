package uniolunisaar.adam.main.ui.cl;

import uniolunisaar.adam.logic.ui.cl.AdamUI;
import uniolunisaar.adam.logic.ui.cl.modules.ModulesAll;

/**
 *
 * @author Manuel Gieseking
 */
public class AdamComplete {

    public static boolean debug = false;

    public static void main(String[] args) {
        AdamUI.main(args, new ModulesAll(), debug);
    }
}
