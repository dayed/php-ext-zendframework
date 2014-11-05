/*

This file is part of the php-ext-zendframework package.

For the full copyright and license information, please view the LICENSE
file that was distributed with this source code.

*/

namespace Zend\Loader;

/**
 * Class-map autoloader
 *
 * Utilizes class-map files to lookup classfile locations.
 */
class ClassMapAutoloader implements SplAutoloader
{
    /**
     * Registry of map files that have already been loaded
     * @var array
     */
    protected mapsLoaded = [];

    /**
     * Class name/filename map
     * @var array
     */
    protected map = [];

    /**
     * Constructor
     *
     * Create a new instance, and optionally configure the autoloader.
     *
     * @param  null|array|Traversable $options
     */
    public function __construct(var options = null)
    {
        if options !== null {
            this->setOptions(options);
        }
    }

    /**
     * Configure the autoloader
     *
     * Proxies to {@link registerAutoloadMaps()}.
     *
     * @param  array|Traversable $options
     * @return ClassMapAutoloader
     */
    public function setOptions(var options) -> <ClassMapAutoloader>
    {
        this->registerAutoloadMaps(options);
        return this;
    }

    /**
     * Register an autoload map
     *
     * An autoload map may be either an associative array, or a file returning
     * an associative array.
     *
     * An autoload map should be an associative array containing
     * classname/file pairs.
     *
     * @param  string|array $map
     * @throws Exception\InvalidArgumentException
     * @return ClassMapAutoloader
     */
    public function registerAutoloadMap(var map) -> <ClassMapAutoloader>
    {
        var exceptionMsg, location, merged;

        if typeof map == "string" {
            let location = map;
            let map = this->loadMapFromFile(location);
            if map === this {
                return this;
            }
        }

        if unlikely typeof map != "array" {
            let exceptionMsg = "Map file provided does not return a map. Map file: \"";
            if empty location {
                let location = "unexpected type: " . typeof map;
            }
            let exceptionMsg = exceptionMsg . location . "\"";
            throw new Exception\InvalidArgumentException(exceptionMsg);
        }

        let merged = array_map(this->map, map);
        let this->map = merged;

        if !empty location {
            let this->mapsLoaded[] = location;
        }
        return this;
    }

    /**
     * Register many autoload maps at once
     *
     * @param  array $locations
     * @throws Exception\InvalidArgumentException
     * @return ClassMapAutoloader
     */
    public function registerAutoloadMaps(var locations) -> <ClassMapAutoloader>
    {
        var location;

        if unlikely typeof locations != "array" && !(locations instanceof Traversable) {
            throw new Exception\InvalidArgumentException("Map list must be an array or implement Traversable");
        }

        for location in locations {
            this->registerAutoloadMap(location);
        }
        return this;
    }

    /**
     * Retrieve current autoload map
     *
     * @return array
     */
    public function getAutoloadMap() -> array
    {
        return this->map;
    }

    /**
     * {@inheritDoc}
     */
    public function autoload(string $class) -> string|boolean
    {
        var path;

        if fetch path, this->map[$class] {
            require path;
            return $class;
        }
        return false;
    }

    /**
     * Register the autoloader with spl_autoload registry
     *
     * @return void
     */
    public function register() -> void
    {
        array autoload;

        let autoload = [this, "autoload"];

        spl_autoload_register(autoload, true, true);
    }

    /**
     * Load a map from a file
     *
     * If the map has been previously loaded, returns the current instance;
     * otherwise, returns whatever was returned by calling include() on the
     * location.
     *
     * @param  string $location
     * @return ClassMapAutoloader|mixed
     * @throws Exception\InvalidArgumentException for nonexistent locations
     */
    protected function loadMapFromFile(string location)
    {
        string exceptionMsg;
        var path, map;
        
        if unlikely !file_exists(location) {
            if typeof location != "string" {
                let location = "unexpected type: " . typeof location;
            }
            let exceptionMsg = "Map file provided does not exist. Map file: \"" . location . "\"";
            throw new Exception\InvalidArgumentException(exceptionMsg);
        }

        let path = static::realPharPath(location);
        if !path {
            let path = realpath(location);
        }
        if in_array(path, this->mapsLoaded) {
            // Already loaded this map
            return this;
        }

        let map = require path;

        return map;
    }

    /**
     * Resolve the real_path() to a file within a phar.
     *
     * @see https://bugs.php.net/bug.php?id=52769
     * @param  string $path
     * @return string
     */
    public static function realPharPath(string path) -> string
    {
        var match = null, value, key, parts, partsFiltered = [], realPath;
        int prefixLength;

        if !preg_match("|^phar:(/{2,3})|", path, match) {
            return "";
        }
        let prefixLength = 5 + strlen(match[1]);
        let parts = explode("/", str_replace(["/", "\\"], "/", substr(path, prefixLength)));
        for value in parts {
            if value !== "" && value !== "." {
                let partsFiltered[] = value;
            }
        }
        let parts = array_values(partsFiltered);
        for key, value in parts {
            if value === ".." {
                unset parts[key];
                unset parts[key - 1];
                let parts = array_values(parts);
            }
        }

        let realPath =  str_pad("phar:", prefixLength, "/") . implode("/", parts);
        if file_exists(realPath) {
            return realPath;
        }
        return "";
    }



}