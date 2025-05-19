{doc-type:doc;doc-version:1.0;doc-title:Azimuth}
**V Stuff** | [V.Dev](/index.html) | [Articles](./index.md)<BR>
# Azimuth  {menu:topics}

Every day we get a new programming language.  Many are created out of curiosity or as learning exercises, while others aim to solve real problems or explore novel ideas. With so many options available, each language brings its own unique concepts and paradigms. As we all know, choosing the "right" language is a question that's specific to the project and often even more personal.

Unfortunately, programming languages often give rise to communities that become ideological silos. In these groups, some individuals adopt a dogmatic belief in the superiority of their chosen language, sometimes even attacking others that differ. **V** is yet another language competing for your attention, and more importantly, it is a very young language striving to establish itself. In its early days, the V community became entangled in online drama due to how some of the language's goals and features were communicated. Critics seized on hyperbolic claims and goals, treating them as contractual promises, and some even accused the project of being a scam. In reality, V’s story is not unlike that of many other community-driven projects.

As a young language, V defining itself, testing ideas and staying pragmatic about its goals. One challenge the V community faces is that most contributors are focused on developing the language itself, which means communication and documentation often take a back seat.

While the language is not defined, this article is a community attempt at a stop-gap solution. **Azimuth** is written for those seeking to understand the ideas behind V, its philosophy, and its direction.

> Disclaimer: This is not an official communication from the V-Lang Project. Please understand that this article is not a formal dissertation on language design, nor does it offer a systematic comparison of languages and features. It is simply a collection of thoughts and opinions on V's design.

# Backends

As of 2021, the primary backend for V is C. Using C allows the community to focus on building the language itself. The C ecosystem provides extensive tooling and cross-platform support. It's a pragmatic choice that enables the generation of production-ready, performant binaries.

LLVM is another possible backend. As a widely used compiler infrastructure, LLVM brings a rich ecosystem of tools and libraries. While LLVM could eventually serve as an alternative backend for V, using C allows us to leverage Clang’s LLVM capabilities today, while retaining flexibility for future tooling options.

# To organize....

This [discussion](https://github.com/microsoft/typescript-go/discussions/411) on Microsoft's decision to use Go for Native TypeScript brings up many perspectives on language ecosystems, tooling, and performance. Many appreciate Go’s ease of development and compatibility, while acknowledging it may not be the most performant. Optimizing code generation is a complex task. Could backends like LLVM eventually become preferred?

Their official statement on the GoLLVM project [reads](https://go.googlesource.com/gollvm):  
> "Gollvm is intended to provide a Go compiler with a more powerful back end, enabling such benefits as better inlining, vectorization, register allocation, etc."

I appreciated one comment posted on this [thread](https://github.com/vlang/v/discussions/7849):  
> "C is the key ingredient of the concrete poured into the foundations of this civilization."  
V sits atop those foundations.



