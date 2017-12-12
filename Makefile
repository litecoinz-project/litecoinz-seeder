CXXFLAGS = -O3 -g0 -march=native
LDFLAGS = $(CXXFLAGS)

litecoinz-seeder: dns.o litecoinz.o netbase.o protocol.o db.o main.o util.o
	g++ -pthread $(LDFLAGS) -o litecoinz-seeder dns.o litecoinz.o netbase.o protocol.o db.o main.o util.o -lcrypto

%.o: %.cpp litecoinz.h netbase.h protocol.h db.h serialize.h uint256.h util.h
	g++ -std=c++11 -pthread $(CXXFLAGS) -Wno-unused -Wno-sign-compare -Wno-reorder -Wno-comment -c -o $@ $<

dns.o: dns.c
	gcc -pthread -std=c99 $(CXXFLAGS) dns.c -c -o dns.o

%.o: %.cpp

clean:
	rm -f *.o litecoinz-seeder
