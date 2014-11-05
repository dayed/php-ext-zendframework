/*

This file is part of the php-ext-zendframework package.

For the full copyright and license information, please view the LICENSE
file that was distributed with this source code.

*/

namespace Zend\Di\ServiceLocator;

use Zend\Code\Generator\ClassGenerator;
use Zend\Code\Generator\FileGenerator;
use Zend\Code\Generator\MethodGenerator;
use Zend\Code\Generator\ParameterGenerator;
use Zend\Di\Di;
use Zend\Di\Exception;

/**
 * Generator that creates the body of a service locator that can emulate the logic of the given Zend\Di\Di instance
 * without class definitions
 */
class Generator
{
    protected containerClass = "ApplicationContext";

    /**
     * @var DependencyInjectorProxy
     */
    protected injector;

    /**
     * @var null|string
     */
    protected $namespace;

    /**
     * Constructor
     *
     * Requires a DependencyInjection manager on which to operate.
     *
     * @param Di $injector
     */
    public function __construct(<Di> injector)
    {
        let this->injector = new DependencyInjectorProxy(injector);
    }

    /**
     * Set the class name for the generated service locator container
     *
     * @param  string    $name
     * @return Generator
     */
    public function setContainerClass(string name) -> <Generator>
    {
        let this->containerClass = name;
        return this;
    }

    /**
     * Set the namespace to use for the generated class file
     *
     * @param  string    $namespace
     * @return Generator
     */
    public function setNamespace(string $namespace) -> <Generator>
    {
        let this->$namespace = $namespace;
        return this;
    }

    /**
     * Construct, configure, and return a PHP class file code generation object
     *
     * Creates a Zend\Code\Generator\FileGenerator object that has
     * created the specified class and service locator methods.
     *
     * @param  null|string                         $filename
     * @throws \Zend\Di\Exception\RuntimeException
     * @return FileGenerator
     */
    public function getCodeGenerator(string filename = null) -> <FileGenerator>
    {
        var classFile;


        // todo: generator
        let classFile = new FileGenerator();

        return classFile;
    }

    /**
     * Reduces aliases
     *
     * Takes alias list and reduces it to a 2-dimensional array of
     * class names pointing to an array of aliases that resolve to
     * it.
     *
     * @param  array $aliasList
     * @return array
     */
    protected function reduceAliases(array! aliasList) -> array
    {
        var reduced = [], aliases, alias, service;

        let aliases = array_keys(aliasList);
        for alias, service in aliasList {
            while in_array(service, aliases) {
                let service = aliasList[service];
            }
            if !isset reduced[service] {
                let reduced[service] = [];
            }
            let reduced[service][] = alias;
        }
        return reduced;
    }

    /**
     * Create a PhpMethod code generation object named after a given alias
     *
     * @param  string          $alias
     * @param  string          $class Class to which alias refers
     * @return MethodGenerator
     */
    protected function getCodeGenMethodFromAlias(string alias, string $class)
    {
        var normalized, method;
        string body;

        let normalized = this->normalizeAlias(alias);
        let method = new MethodGenerator();
        let body = "return $this->get('" . $class . "');";

        method->setName(alias);
        method->setBody(body);

        return method;

    }

    /**
     * Normalize an alias to a getter method name
     *
     * @param  string $alias
     * @return string
     */
    protected function normalizeAlias(string alias) -> string
    {
        var normalized;

        let normalized = preg_replace("/[^a-zA-Z0-9]/", " ", alias);
        let normalized = ucwords(normalized);
        let normalized = "get" . str_replace(" ", "", normalized);

        return normalized;
    }

}
