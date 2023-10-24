Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4737D4E96
	for <lists+linux-block@lfdr.de>; Tue, 24 Oct 2023 13:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjJXLKX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 Oct 2023 07:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjJXLKW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Oct 2023 07:10:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F56D7F;
        Tue, 24 Oct 2023 04:10:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8D36921B8B;
        Tue, 24 Oct 2023 11:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698145815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7GNlnvsY+DYZUeQFr2rzYE4qXsApeBSmjyzIRlCaWx0=;
        b=AdYr1z2/jHeJpL4z4hGxWiB7//ZUIxp2jgoOHeqSVfXKkVcJ7kqcsfhYzqi72WfnNzip3v
        UZJx0QROGCCMwG3hUh2TE7K50ZzsqlxQQ249fRhPqTN5xcEO1R9/XXfWIbqzV9qfCm+8iN
        UQfZVyj0AIXBalggihFi3iu6xhRLMm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698145815;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7GNlnvsY+DYZUeQFr2rzYE4qXsApeBSmjyzIRlCaWx0=;
        b=upfptmnJVvkV+Biac6KUb3cLwMsJzIcVLVwasmaBvvzuA3gdF+2uJV1j9Ns+HPe3S+AAzA
        +JQJrDcWnq3u8EDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B1151391C;
        Tue, 24 Oct 2023 11:10:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Kgz4HRemN2W7PAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 24 Oct 2023 11:10:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0942CA05BC; Tue, 24 Oct 2023 13:10:15 +0200 (CEST)
Date:   Tue, 24 Oct 2023 13:10:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     Jan Kara <jack@suse.cz>, Eric Biggers <ebiggers@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 1/6] block: Add config option to not allow writing to
 mounted devices
Message-ID: <20231024111015.k4sbjpw5fa46k6il@quack3>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-1-jack@suse.cz>
 <20230822053523.GA8949@sol.localdomain>
 <20230822101154.7udsf4tdwtns2prj@quack3>
 <CANp29Y6uBuSzLXuCMGzVNZjT+xFqV4dtWKWb7GR7Opx__Diuzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANp29Y6uBuSzLXuCMGzVNZjT+xFqV4dtWKWb7GR7Opx__Diuzg@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.10
X-Spamd-Result: default: False [-5.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_TWELVE(0.00)[15];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-1.50)[91.72%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi!

On Thu 19-10-23 11:16:55, Aleksandr Nogikh wrote:
> Thank you for the series!
> 
> Have you already had a chance to push an updated version of it?
> I tried to search LKML, but didn't find anything.
> 
> Or did you decide to put it off until later?

So there is preliminary series sitting in VFS tree that changes how block
devices are open. There are some conflicts with btrfs tree and bcachefs
merge that complicate all this (plus there was quite some churn in VFS
itself due to changing rules how block devices are open) so I didn't push
out the series that actually forbids opening of mounted block devices
because that would cause a "merge from hell" issues. I plan to push out the
remaining patches once the merge window closes and all the dependencies are
hopefully in a stable state. Maybe I can push out the series earlier based
on linux-next so that people can have a look at the current state.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
